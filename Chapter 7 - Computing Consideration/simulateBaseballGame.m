function runs=simulate_baseball_game(prob_single, prob_double, prob_triple,prob_hr,prob_walk)
%runs=simulate_baseball_game(prob_single, prob_double, prob_hr,prob_walk)
%Simulate a baseball game.  Return the number of runs scored in the game. 
%will simulate 9 innings, 3 outs per inning, but allows the possibility of more
%or less than 9 batters in the lineup. 
%INPUT
%prob_single - A vector of length N (number of players in lineup) such that 
%prob_single(i) is the probablity that the player batting i^th in the lineup hits
%exactly a single. 
%
%prob_double - the natural thing given the definition of prob_single.
%
%prob_hr - A vector containing the probability that the player batting i^th in 
%in the lineup hits a homerun in position i. 
%
%prob_walk - the naturual thing.
%
%OUTPUT
%runs - the number of runs scored in this simulated game.  This simulation 
%follows a very simple set of rules, but does indeed give reasonable results. 
%It does not account for the quality of the defense in any way, and does not 
%account for speed, situational hitting, etc. in any way. 
    ab_idx=1;
    runs=0;
    occupied=[0 0 0];
    for inning=1:9
        outs=0;
        while outs<3
            x=rand(1);
            if x<prob_single(ab_idx)
                %A single occurs
                %any runner on second or third scores. 
                %a runner on first is now on third. 
                %first becomes occupied.
                if occupied(3)==1
                    runs=runs+1;
                    occupied(3)=0;
                end
                if occupied(2)==1
                    runs=runs+1;
                    occupied(2)=0;
                end
                if occupied(1)==1
                    occupied(1)=0;
                    occupied(3)=1;
                end
                occupied(1)=1;
                   
            elseif x<prob_single(ab_idx)+prob_double(ab_idx)
                %A double occurs.  All runners on base score. Second
                %becomes occupied. 
                runs=runs+sum(occupied);
                occupied(1:3)=0;
                occupied(2)=1;
            elseif x<prob_single(ab_idx)+prob_double(ab_idx)+prob_triple(ab_idx)
                %A triple occurs.  All runners on base score, third becomes occupied.
                runs=runs+sum(occupied);
                occupied(1:3)=0;
                occupied(3)=1;
            elseif x<prob_single(ab_idx)+prob_double(ab_idx)+prob_triple(ab_idx)+prob_hr(ab_idx)
                %a homerun occurs. All runners score, the bases are
                %emptied.
                runs=runs+sum(occupied)+1;
                occupied(1:3)=0;
            elseif x<prob_single(ab_idx)+prob_double(ab_idx)+prob_hr(ab_idx)+prob_walk(ab_idx)
                %A walk occurs.  Runners that are pushed forward by the
                %walk advance.  A runner may score if pushed in.
                
                %where is the first free base?
                first_open=find(occupied==0);
                %if there are no bases open, then a run gets pushed in, and
                %the bases stay loaded
                if isempty(first_open)
                    runs=runs+1;
                else
                    first_open=min(first_open); %first free base
                    occupied(1:first_open)=0; %now all bases, up to and including first_open, are occupied. 
                end
                    
                        
            else
                %an out occurs.  No movement on basepaths, no runs score.
                outs=outs+1;
            end
            ab_idx=ab_idx+1;
            if ab_idx>length(prob_single)
                ab_idx=1;
            end
        end
    end